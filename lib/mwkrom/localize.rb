module Mwkrom
  module Localize


    def mkt_debug_loc?
      !! (defined?(MKT_DEBUG_LOC) && (MKT_DEBUG_LOC)  )
    end

    def mkt_with_scope(scope_name, &block)
      @mkt_scope_names ||= []
      @mkt_scope_names.push(scope_name)
      r = yield
      @mkt_scope_names.pop
      r
    end

    def mkt(*args)
      xtras = ((sc = (@mkt_scope_names && @mkt_scope_names.last)) ? {:scope => sc} : {})
      r = I18n.t(args[0], (args[1] || {}).merge(xtras))
      if mkt_debug_loc?
        mkt_as_debug(r)
      else
        r
      end
    end

    def mkt_as_debug(x)
      "&#9733;#{x}&#9733;"
    end

  end
end
