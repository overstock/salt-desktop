# -*- coding: utf-8 -*-
# vim: ft=yaml
---
postgres:
  users:
    airflow:
      ensure: present
      password: airflow
      createdb: true
      inherit: true
      createroles: true
      replication: true
  databases:
    airflow:
      owner: airflow
  acls:
    - ['local', 'airflow', 'airflow', 'md5']
    - ['local', 'all', 'all', 'peer']
    - ['host', 'all', 'all', '127.0.0.1/32', 'md5']
    - ['host', 'all', 'all', '::1/128', 'md5']
    - ['local', 'replication', 'all', 'peer']
    - ['host', 'replication', 'all', '127.0.0.1/32', 'md5']
    - ['host', 'replication', 'all', '::1/128', 'md5']

airflow:
  security:
    airflow:
      user: airflow
      pass: airflow
      email: airflow@localhost
  config:
    airflow:
      content:
        core:
          authentication: True
          executor: CeleryExecutor   # LocalExecutor
          load_examples: True
      state_colors:
        # https://airflow.apache.org/docs/apache-airflow/stable/howto/customize-state-colors-ui.html
        queued: 'darkgray'
        running: '#01FF70'
        success: '#2ECC40'
        failed: 'firebrick'
        up_for_retry: 'yellow'
        up_for_reschedule: 'turquoise'
        upstream_failed: 'orange'
        skipped: 'darkorchid'
        scheduled: 'tan'
  service:
    airflow:
      enabled:
        - airflow-celery-flower
        - airflow-scheduler
        - airflow-webserver
        - airflow-celery-worker
  pkg:
    airflow:
      version: 2.0.0rc1  # 1.10.14
      use_upstream: pip
      extras:
        # https://airflow.apache.org/docs/apache-airflow/stable/installation.html#extra-packages
        # Most things selected. I omitted what is not verified or troublesome.
        - devel             # Minimum dev tools requirements
        # apache.atlas      # Apache Atlas to use Data Lineage feature
        # apache.cassandra  # Cassandra related operators & hook
        # apache.druid      # Druid related operators & hooks
        # apache.hdfs       # HDFS hooks and operators
        # apache.hive       # All Hive related operators
        # apache.presto     # All Presto related operators & hooks
        # webhdfs           # HDFS hooks and operators
        - amazon               # aws
        - microsoft.azure      # azure
        # azure_blob_storage
        # azure_cosmos
        # azure_container_instances
        # azure_data_lake
        # azure_secrets
        - databricks           # Databricks hooks and operators
        - datadog              # Datadog hooks and sensors
        - gcp                  # Google Cloud
        # github_enterprise    # GitHub Enterprise auth backend
        - google_auth          # Google auth backend
        - hashicorp            # Hashicorp Services (Vault)
        # qds                  # Enable QDS (Qubole Data Service) support
        # salesforce           # Salesforce hook
        # sendgrid             # Send email using sendgrid
        # segment              # Segment hooks and sensors
        # sentry
        - slack                # airflow.providers.slack.operators.slack.SlackAPIOperator
        # vertica              # Vertica hook support as an Airflow backend
        - async                # Async worker classes for Gunicorn
        - elasticsearch        # Elasticsearch hooks and Log Handler
        - mongo                # Mongo hooks and operators
        - mysql                # MySQL operators and hook, support as Airflow backend (mysql 5.6.4+)
        # pinot                # Pinot DB hook
        - postgres             # PostgreSQL operators and hook, support as an Airflow backend
        - rabbitmq             # RabbitMQ support as a Celery backend
        - redis                # Redis hooks and sensors
        - samba                # airflow.providers.apache.hive.transfers.hive_to_samba.HiveToSambaOperator
        # statsd               # Needed by StatsD metrics
        - virtualenv
        - cgroups              # Needed To use CgroupTaskRunner
        - crypto               # Cryptography libraries
        - grpc                 # Grpc hooks and operators
        - ldap                 # LDAP authentication for users
        # papermill            # Papermill hooks and operators
        - jira                 # Jira hooks and operators
        - password             # Password authentication for users
        - docker               # Docker hooks and operators
        - celery               # CeleryExecutor
        - dask                 # DaskExecutor
        - kubernetes           # Kubernetes Executor and operator
        - ssh                  # SSH hooks and Operator
        - winrm                # WinRM hooks and operators

  dir:
    airflow:
      config: /home/airflow/airflow
  linux:
    altpriority: 0   # zero disables alternatives

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
