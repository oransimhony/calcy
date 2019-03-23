defmodule Calcy.Lexer do
    @moduledoc """
    Documentation for the Lexer.
    """

    @doc """
    Tokenizes an input string
    """
    @spec lex(binary) :: list
    def lex(input) do
        {:ok, tokens, _line} = input |> to_charlist |> :lexer.string
        tokens
    end
end