class auto_jenkin {
  User['jenkins'] -> Auto_jenkin::Job <| |>

  file { '/var/lib/jenkins/jobs':
    ensure    => directory,
    owner     => 'jenkins',
    group     => 'jenkins',
    mode      => '755'
  }
}
