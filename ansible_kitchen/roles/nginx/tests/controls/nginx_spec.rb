# encoding: utf-8

title 'Nginx Installation'

control 'Nginx-01' do
  impact 1.0
  title 'Nginx should be installed'
  desc 'Nginx is installed using the package manager.'
  
  describe package('nginx') do
      it { should be_installed }
  end
end
