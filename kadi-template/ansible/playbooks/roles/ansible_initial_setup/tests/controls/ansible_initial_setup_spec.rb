# encoding: utf-8

INITIAL_USER_PUBLIC_KEY = attribute(
  'initial_user_public_key',
  default: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCblqvnD0Fv3tROAv6QO6v2X+T3PlpNirTBZPubsSe8FUP6XFR/MMpLIqeRg4N0jIHkuEm/QUsGcXw3n1DJo5J6rLvUsQw88uBvl723UqL1EDZ1iYXJ3VRCA4HKOLi1vRxE8K8E65Le0OTT7hP0yV7TFStlZd6markTG/sG83YRhQrXR6L0W4dDqn27FfWupY4gzd5vEZFsFXIP7DZaUIPuq2uFen/HbLa1WjFYSmk+XLnETMatd84ME3yfOcw2HsAR+Uhg9MzTggZT9/B5icDl4HuIZCXLPVlhuuCUiJN7slAY9NM5yXb1TTY7ZOJcYQqKyL3wgd32tkEmESXk/anNWWOaYvc7D7Zr/IU0kf1cncLdGHEX+Xw9DBbpgtzSaQkgFtmaJCdRzME2KRmR7HQQP0j02g8N448xctnDEkXC1t/1dp0ZOzf4Nmh2j9OOPVUnX96RSlfStlZgCc5vVmoTom/GXSoEn3s8UAQGzehUAoVoc2mGGwFymPNnLfo4ycuVDCPW3CR6wUWCSxdHkFzJQd9ijrN+OhlshVWV55AGKTJJqiy1jL/22t17TRSGhMbWLmejtBE/wpaQv+uGd8MMfizvqaitX0obAadzoiPGX2GcyoIvQqzyFuA99b9+P2mcaBUYCbd9PIWl1SklC0aPyn14+8rxpdI4Pk8G',
  description: '
      This is the public key of the inital user.
      This initial user is configured in Kitchen.yml created by the tool to access through SSH. Its needed to create the rest of the users, because all the ansible playbooks with SSH connection require this connection start with this user.
  '
)

ANSIBLE_INITIAL_USER = attribute(
  'ansible_initial_user',
  default: 'ansible',
  description: '
      This var reperesents the user used by inspec to test the machine.
      Right now we dont have a super user to perform the connections to the machine to validate that users are correctly configured.
      Because of that, when we execute this tests in any machines it will fail because the user used to connect to the machines dont have permissions over other HOME directories.

      The solution to manage this problem is to check if this variable exists, and if its defined then check if match with some of the users being tested (admin, app or belk at time of writting this).
      This way we can only test this role partially.
  '
)

control 'AnsibleInitialSetup-01' do
  impact 1.0
  title 'Initial user should be well configured'
  desc 'This user need to perform ssh INITIAL_USER@localhost to test connections through SSH'

  describe file("/home/#{ANSIBLE_INITIAL_USER }/.ssh") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by ANSIBLE_INITIAL_USER }
    its('mode') { should cmp '0700' }
  end

  describe file("/home/#{ANSIBLE_INITIAL_USER }/.ssh/authorized_keys") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by ANSIBLE_INITIAL_USER }
    its('mode') { should cmp '0600' }
    its('content') { should include(INITIAL_USER_PUBLIC_KEY) }
  end
end
