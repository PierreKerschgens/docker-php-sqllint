#!/bin/bash
destination=${1:-.}
! find $destination -type f -iname "*.sql" -not -path "*-no-lint.sql" -exec php-sqllint {} \; | grep .
