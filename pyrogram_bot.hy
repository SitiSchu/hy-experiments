; Imports
(import [pyrogram [Client filters handlers]])
(import logging)

; Setting up logging
(logging.basicConfig :level logging.INFO)

; Configurations
(setv api_id 1)
(setv api_hash "")


; Client
(setv app 
    (Client :session_name "bot" :api_id api_id :api_hash api_hash))


; Command function
(defn/a hello [client message]
    (await (message.reply "hello")))

; adding command fucntion to message handler
(app.add_handler (handlers.MessageHandler hello :filters (filters.command "hello")))

; running the client
(app.run)
