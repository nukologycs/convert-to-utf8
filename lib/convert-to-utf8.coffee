fs    = require 'fs'
iconv = require 'iconv-lite'

module.exports =

  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'user:insert-date'           : () => @open 'shift_jis'
      "convert-to-utf8:shift_jis"  : () => @open 'shift_jis'
      "convert-to-utf8:euc-jp"     : () => @open 'euc-jp'
      "convert-to-utf8:cp932"      : () => @open 'cp932'
      "convert-to-utf8:gbk"        : () => @open 'gbk'
      "convert-to-utf8:big5"       : () => @open 'big5'
      "convert-to-utf8:big5-hkscs" : () => @open 'big5-hkscs'
      "convert-to-utf8:euc-kr"     : () => @open 'euc-kr'
      "convert-to-utf8:utf-8"      : () => @open 'utf-8'

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  open: (encoding) ->
    editor = atom.workspace.getActiveTextEditor()
    uri = editor.getURI()
    buffer = fs.readFileSync(uri)
    convertedText = iconv.decode buffer, encoding
    editor.setText convertedText
    # atom.workspace.saveActivePaneItem()

  save: (encoding) ->
    editor = atom.workspace.getActiveTextEditor()
    uri = editor.getURI()
    buffer = fs.readFileSync(uri)
    data = buffer.toString 'UTF8'
    buf = iconv.encode data, encoding
    fs.writeFileSync( uri, buf )
