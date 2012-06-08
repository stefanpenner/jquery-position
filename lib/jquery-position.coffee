(($) ->

  class RelativePositioning
    constructor: (@parent,@child,@opts={}) ->

      throw "[Relative Positioning] Missing a Parent" unless @parent
      throw "[Relative Positioning] Missing a Child"  unless @child

      @parent = $ @parent
      @child  = $ @child

      @options  = @opts

      @isEnabled = false

      RelativePositioning.positionings.push @

    enabled: ->
      @isEnabled = true

    enabled: ->
      @isDisabled = true

    position: -> $(window).resize(@.respondToResize).trigger('resize')

    respondToResize: (e) =>
      topFromParent   = @child.data('top')  or @parent.data('top' )
      leftFromParent  = @child.data('left') or @parent.data('left')

      offsetTop  = @options.top  or topFromParent  or 0
      offsetLeft = @options.left or leftFromParent or 0

      offsetTop  = 0 if @options.top  is "none"
      offsetLeft = 0 if @options.left is "none"

      offset = @parent.offset()
      top    = offset.top + offsetTop
      left   = offset.left + offsetLeft

      @child.css
        left: left
        top: top

  RelativePositioning.positionings = []

  $.fn.positionRelativeTo = (parent, opts) ->
    return unless @.length > 0

    parent = parent or this.data('position-relative-to')
    new RelativePositioning(parent,this,opts).position()

  $.fn.positionRelative = (child, opts) ->
    return unless @.length > 0

    child = child or this.data('position-relative')
    new RelativePositioning(this,child,opts).position()

  $ ->
    $('[data-position-relative-to]').positionRelativeTo()
    $('[data-position-relative]').positionRelative()

)(jQuery)
