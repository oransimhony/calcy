defmodule Calcy.Parser do
    @moduledoc """
    Documentation for the Parser.
    """
    
    @doc """
    Parses a list of tokens
    """
    @spec parse(list) :: tuple
    def parse(tokens) do
        {:ok, tree} = tokens |> :parser.parse
        tree
    end
end