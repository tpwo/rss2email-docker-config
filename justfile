# show this help message and exit
help:
	just --list

# start service
up:
	just _check_dot_env
	just _check_feeds_txt
	docker compose up --detach

# stop service
stop:
	docker compose stop

# after adding new feeds, register them in db, so there won't be email spam
update:
	just _check_dot_env
	docker compose run --remove-orphans rss2email cron -send=false user@example.com

# list feeds
listFeeds:
	docker compose exec rss2email rss2email list

# add a new feed
add feed:
	docker compose exec rss2email rss2email add {{feed}}

# delete a feed
delete feed:
	docker compose exec rss2email rss2email delete {{feed}}

# show sent emails from the last 24h
sent since='24h':
    docker compose logs rss2email --since {{since}} | grep 'email sent' | awk -F ' [a-z\.]+=' '{print $2 " " $8 " " $7}'

# show errors from the last 24h
errors since='24h':
	docker compose logs rss2email --since {{since}} | grep error || exit 0

# run a custom command in the running container
command +cmd:
	docker compose exec rss2email {{cmd}}

# apply yt template to all yt feeds
applyYtTemplate:
	cat state/feeds.txt | awk '/^https:\/\/www\.youtube\.com\/feeds\/videos\.xml/ { \
	    print; \
	    getline nextLine; \
	    if (nextLine != " - template: templates/youtube.tmpl") { \
		print " - template: templates/youtube.tmpl"; \
	    } else { \
		print nextLine; \
	    } \
	    next; \
	}  \
	{ print }'

_check_dot_env:
	test -f .env || echo '.env file not found' || exit 1

_check_feeds_txt:
	test -f state/feeds.txt || (echo 'creating empty feeds.txt as not found' && echo touch state/feeds.txt)
