# rss2email-docker

> [!WARNING]
> This project is deprecated. [rss2email](https://github.com/skx/rss2email) running under the hood was deprecated as well. The best alternative is switching to the original `rss2email` written in Python:
> https://github.com/rss2email/rss2email
>
> This repo wasn't updated to work with Python version, as I noticed that running it locally on my daily driver machine is more straightforward than setting it up in LAN.
>
> With `cron` you can very easily set up the following to fetch RSS every 15 minutes with the original Python project:
>
> ```
> $ crontab -l
>   0/15 * * * * ~/.local/bin/r2e run >> /dev/null 2>&1`
> ```

Run your instance of [rss2email](https://github.com/skx/rss2email) in Docker.

## Requirements

* Docker with compose
* [just](https://github.com/casey/just) command runner

## Initial setup

Clone repo and enter the folder:

```
git clone https://github.com/tpwo/rss2email-docker-config
cd rss2email-docker-config
```

Create `.env` file by providing your values for:

- `SMTP_USERNAME` -> recipient and sender address
- `SMTP_PASSWORD` -> your email password, e.g. for Gmail you have to enable 2FA and create an app password [here](https://myaccount.google.com/apppasswords)
- `SMTP_HOST` -> e.g. `smtp.gmail.com` for Gmail
- `SMTP_PORT` -> e.g. `587` for Gmail

You can copy the sample file and edit it:

```
cp .env{.sample,}
```

## Running

To start:

```
just up
```

To stop:

```
just stop
```

See all commands:

```
just
```
