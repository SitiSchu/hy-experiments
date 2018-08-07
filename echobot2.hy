(import [telegram.ext [Updater CommandHandler MessageHandler Filters]])
(import logging)
(import config)

; Enable logging
(logging.basicConfig :format "%(asctime)s - %(name)s - %(levelname)s - %(message)s" :level logging.INFO)

(setv logger (logging.getLogger __name__))


; Define a few command handlers. These usually take the two arguments bot and
; update. Error handlers also receive the raised TelegramError object in error.

(defn start [bot update]
    "Send a message when the command /start is issued."
    (update.message.reply_text "Hi! I'm written in Hy."))

(defn help [bot update]
    "Send a message when the command /help is issued."
    (update.message.reply_text "/start - Start the bot
/help - Show the help
/source - Link to the Source Code"))

(defn echo [bot update]
    "Echo the user message."
    (update.message.reply_text update.message.text))

(defn source [bot update]
    "Send link to he bots source Code"
    (update.message.reply_text "My Source Code is on [GitHub](https://github.com/SitiSchu/hy-experiments/blob/master/echobot2.hy)." :parse_mode "Markdown"))

(defn error [bot update]
    "Log Errors caused by Updates."
    (logger.warning "Update %s caused error %s" update error))

(defn main []
    "Start the bot."
    ; Create the EventHandler and pass it your bot's token.
    (setv updater (Updater config.token))

    ; Get the dispatcher to register handlers
    (setv dp updater.dispatcher)

    ; on different commands - answer in Telegram
    (dp.add_handler (CommandHandler "start" start))
    (dp.add_handler (CommandHandler "help" help))
    (dp.add_handler (CommandHandler "source" source))

    ; on noncommand i.e message - echo the message on Telegram
    (dp.add_handler(MessageHandler Filters.text echo))

    ; log all errors
    (dp.add_error_handler error)

    ; Start the Bot
    (updater.start_polling)

    ; Run the bot until you press Ctrl-C or the process receives SIGINT,
    ; SIGTERM or SIGABRT. This should be used most of the time, since
    ; start_polling() is non-blocking and will stop the bot gracefully.
    (updater.idle))

; if __name__ == '__main__':
    ; main()
(main)
