module Sumsub
  module Struct
    class BaseStruct < Dry::Struct
      include Types

      def to_json
        attributes.to_json
      end
    end
  end
end
