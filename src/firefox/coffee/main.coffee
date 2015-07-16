{background}     = require './background'
{bgMessenger}    = require './bg_messenger'
{popup} = require './browser'
http    = require './http'
tabs    = require 'sdk/tabs'

exports.main = (options, callbacks) ->
    if options.loadReason == 'install'
        http.getLocation () ->
            #open 1clickBOM preferences
            tabs.open(
              url: 'about:addons',
              onReady: (tab) ->
                tab.attach(
                  contentScriptWhen: 'end',
                  contentScript:"
                      AddonManager.getAddonByID('1clickBOM@monostable', function(aAddon) {\n
                        window.gViewController.commands
                            .cmd_showItemDetails.doCommand(aAddon, true);\n
                      });\n"
                )
            )

    background(bgMessenger(popup))
