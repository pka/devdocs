module Docs
  class Pyqt
    class CleanNavFilter < Filter
      def call
        css('table[width="100%"]').remove
        css('address').remove
        doc
      end
    end
  end
end
