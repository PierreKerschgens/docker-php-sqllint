# docker-php-sqllint

I want to use [php-sqllint](https://github.com/cweiske/php-sqllint) in a Docker container.

## usage
run `bash /opt/lint.sh /path/to/.sql-files` for recurse-mode or use `php-sqllint /path/to/.sql-file` for single files.

## ignore specific files
`bash /opt/lint.sh /path/to/.sql-files` will ignore *-no-lint.sql files like `false-positive-no-lint.sql`
