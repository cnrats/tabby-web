#!/bin/sh
if [[ -n "$DOCKERIZE_ARGS" ]]; then
    dockerize $DOCKERIZE_ARGS
fi

cd /app
/venv/*/bin/python ./manage.py migrate
/venv/*/bin/python ./manage.py collectstatic --noinput
exec /venv/*/bin/gunicorn --bind 0.0.0.0:8000 --workers 4 --timeout 120 tabby.wsgi:application
