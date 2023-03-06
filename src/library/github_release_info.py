#!/usr/bin/python
# Copyright: (c) 2023, Sylvain Gaunet <sgaunet@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

ANSIBLE_METADATA = {
    'metadata_version': '0.1',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: github_release_info

short_description: Module to retrieve information about the github release of a repository

version_added: "2.4"

description:
    - "Module to retrieve information about the github release of a repository"

options:
    url_api:
        description:
            - Url of githab api (default: https://api.github.com)
        required: false
    repository:
        description:
            - repository name (ex: sgaunet/conf-linux)
        required: true

author:
    - Sylvain Gaunet
'''

EXAMPLES = '''
# example of use
- name: get release informations of sgaunet/calcdate
  github_release_info:
    # url_api: ""
    repository: "sgaunet/calcdate"
  register: project_info

- debug:
    msg: "{{ project_info }}"

- debug:
    msg: "{{ project_info.response_json.tag_name }}"
'''


RETURN = '''
response_json:
    description: Get the latest github release: https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#get-the-latest-release
    type: str
    returned: if success
'''

from ansible.module_utils.basic import AnsibleModule
import subprocess
import os
import re
import requests


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        url_api=dict(type='str', required=False, default="https://api.github.com"),
        repository=dict(type='str', required=True)
    )

    # Ansible diff output
    diff = {
        'before': "",
        'after': "",
    }

    # seed the result dict in the object
    # we primarily care about changed and state
    # change is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    try:
        # A GET request to the API
        response = requests.get(module.params['url_api']+"/repos/"+module.params['repository']+"/releases/latest")
        # manipulate or modify the state as needed (this is going to be the
        # part where your module will do what it needs to do)
        if response.status_code != 200:
            result['failed'] = True
            result['message'] = "github repository not found"
        else:
            result['response_json'] = response.json()
    except Exception as e:
        module.fail_json(msg=str(e), **result)
    
    # if module._diff:
    #     result['failed'] = True
    #     module.fail_json(msg='DIFF MODE', **result)

    # diff['before'] = actual_value
    # diff['after'] = params_value
    
    # if actual_value == params_value:
    #     # value unchanged
    #     result['changed']= False
    # else:
    #     if module.check_mode:
    #         # Check mode, no modification
    #         result['changed']= True
    #         result['diff'] = diff
    #     else:
    #         exec_cmd(set_value_cmd)
    #         new_value = remove_eol_and_quotes(exec_cmd(get_value_cmd))
    #         if params_value == new_value:
    #             result['changed']= True
    #             result['new_value'] = new_value
    #             result['params_value'] = params_value
    #             result['actual_value'] = actual_value
    #             result['diff'] = diff
    #         else:
    #             result['failed'] = True
    #             result['new_value'] = new_value
    #             result['params_value'] = params_value
    #             result['actual_value'] = actual_value
    #             result['changed']= False
    #             result['diff'] = diff

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)

def main():
    run_module()

if __name__ == '__main__':
    main()

