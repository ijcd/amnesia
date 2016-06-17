defmodule Amnesia.Table.Coercer do
  defmacro __using__(name: name, attributes: attributes) do
    quote bind_quoted: [
      name: name,
      attributes: attributes,
    ] do
      @doc false
      def coerce(unquote({ :%, [], [{ :__MODULE__, [], nil }, { :%{}, [],
        for { key, _ } <- attributes do
          { key, { key, [], nil } }
        end
      }] })) do
        unquote({ :{}, [], [name |
          for { key, _ } <- attributes do
            { key, [], nil }
          end
        ] })
      end

      def coerce(unquote({ :{}, [], [name |
        for { key, _ } <- attributes do
          { key, [], nil }
        end
      ] })) do
        unquote({ :%, [], [{ :__MODULE__, [], nil }, { :%{}, [],
          for { key, _ } <- attributes do
            { key, { key, [], nil } }
          end
        }] })
      end

      def coerce(list) when list |> is_list do
        Enum.map(list, &coerce/1)
      end

      def coerce(value) do
        value
      end
    end
  end
end