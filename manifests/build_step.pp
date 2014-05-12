define auto_jenkin::build_step (
  $job,
  $command,
  $type     = 'hudson.tasks.Shell'
) {
  $job_config = "/var/lib/jenkins/jobs/${job}/config.xml"

  concat::fragment { "build_step-${name}":
    target    => $job_config,
    content   => template("${module_name}/build_step.erb"),
    order     => '20'
  }
}
