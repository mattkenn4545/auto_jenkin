define auto_jenkin::job (
  $repository,
  $branch       = 'master'
) {
  include auto_jenkin

  file { "/var/lib/jenkins/jobs/${name}":
    ensure    => directory,
    owner     => 'jenkins',
    group     => 'jenkins',
    mode      => '755',
    require   => File['/var/lib/jenkins/jobs']
  }

  $job_config = "/var/lib/jenkins/jobs/${name}/config.xml"

  if !(defined(File[$job_config])) {
    concat { $job_config:
      owner     => 'jenkins',
      group     => 'jenkins',
      mode      => '644',
      notify    => Service[ 'jenkins' ]
    }

    concat::fragment { "pre-${name}":
      target    => $job_config,
      content   => template("${module_name}/pre-job.config.xml.erb"),
      order     => '01'
    }

    concat::fragment { "post-${name}":
      target    => $job_config,
      content   => template("${module_name}/post-job.config.xml.erb"),
      order     => '90'
    }
  }

  Auto_jenkin::Build_step <<| job == $name |>>
}
