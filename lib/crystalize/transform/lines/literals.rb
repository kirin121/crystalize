module Crystalize
  module Transform
    module Line
      module Literals
        def transform_array_literal(line)
          if lambda_call_in_line?(line)
            line
          else
            line.gsub '[]', "Array(Anything).new"
          end
        end

        def transform_hash_literal(line)
          line.gsub '{}', 'Hash(Anything, Anything).new'
        end

        def lambda_call_in_line?(line)
          # Here is omitting calls like
          # lambda_method       []
          # due to bad code style of lambda call, even this
          # lambda call is correct
          braces = /[\[][ ]*[\]]/
          line.match /(\w+|[.])#{braces}/
        end
      end
    end
  end
end