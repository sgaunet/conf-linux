#!/usr/bin/env bash

# testWithMolecule will run tests with molecule
# this function expects to be in the folder of the role to test
# it will exit 1 in case of error
function testWithMolecule
{
    log=/tmp/molecule.$$
    logerr=/tmp/molecule.err.$$
    molecule destroy >/dev/null 2>&1
    molecule converge > "${log}" 2> "${logerr}"
    rc=$?
    if [ "$rc" != "0" ]; then
        \rm "${log}"
        echo "molecule converge returns code $rc. Check log ${logerr}"
        exit 1
    fi
    ansible-summary -input "${log}" > /dev/null 2>&1
    rc=$?
    if [ "$rc" == "1" ]
    then
        \rm "${log}"
        echo "error occured. Check log ${logerr}. exit 1"
        exit 1
    fi
    if [ "$rc" == "0" ]; then
        \rm "${log}"
        echo "no change, very weird... investigate. Check log ${logerr}. exit 1"
        exit 1
    fi
    molecule converge > "${log}" 2> "${logerr}"
    rc=$?
    if [ "$rc" != "0" ]; then
        \rm "${log}"
        echo "molecule converge returns code $rc. Check log ${logerr}"
        exit 1
    fi
    ansible-summary -input "${log}" > /dev/null 2>&1
    rc=$?
    # ansible-summary doit pas remonter de changement sinon le role n'est pas indepotent
    if [ "$rc" != "0" ]; then
        \rm "${log}"
        echo "expected exit code 0 for ansible-summary (got $rc). Check log ${logerr}"
        exit 1
    fi
    \rm "${log}" "${logerr}"
    echo "everything is OK"
}

export ANSIBLE_CALLBACKS_ENABLED=json
export ANSIBLE_STDOUT_CALLBACK=json 

# !TODO: check repository is up to date
# !TODO: check that main branch is active

role_folder_to_update="$1"

# check parameter
if [ -z "${role_folder_to_update}" ]; then
    echo "usage: $0 <role to update>"
    exit 1
fi

if [ ! -d "${role_folder_to_update}" ]; then
    echo "folder ${role_folder_to_update} do nost exist. exit 1"
    exit 1
fi

if [ ! -d "${role_folder_to_update}/molecule" ]; then
    echo "role does not contain molecule to test it. exit 1"
    exit 1
fi

cd "${role_folder_to_update}" || exit 1
    testWithMolecule
    molecule destroy >/dev/null 2>&1
cd - > /dev/null 2>&1 || exit 1
