#coding: UTF-8

Plugin.create(:"mikutter-command-quote-hashtag") {
  command(:quote_hashtag,
          :name => _("ハッシュタグを引用"),
          :condition => lambda { |opt| 
	    Plugin::Command[:HasOneMessage] &&
            opt.messages[0][:entities] &&
            (opt.messages[0][:entities][:hashtags].count != 0)
	  },
          :visible => true,
          :role => :timeline) { |opt|
    message = opt.messages[0][:entities][:hashtags].map { |_| "\##{_[:text]}" }.join(" ")
    
    postbox = Plugin::GUI::Postbox.instance
    postbox.options = {footer: message, delegate_other: false}
    Plugin::GUI::Window.instance(:default) << postbox
  }
}
