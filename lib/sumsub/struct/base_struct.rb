module Sumsub
  include Types

  module Struct
    class BaseStruct < Dry::Struct

      def to_json
        attributes.to_json
      end
    end
  end
end
