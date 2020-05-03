@test "the thing is done correctly" {
  grep "root" /etc/passwd
}

@test "Httpd is installed and in the path" {
  which httpd
}



