# encoding: utf-8

title 'HTTPD Installation'

control 'Httpd-01' do
  impact 1.0
  title 'Httpd should be installed'
  desc 'Httpd is installed using the package manager.'
  
  describe package('httpd') do
      it { should be_installed }
  end
end
