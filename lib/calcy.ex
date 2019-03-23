defmodule Calcy do
  @moduledoc """
  Documentation for Calcy.
  """

  @doc """
  Runs over input and tokenizes it
  """
  def run(input, env) do
    tokens = Calcy.Lexer.lex(input)
    case length(tokens) do
      0 -> {}
      _ -> continue(tokens, env)
    end
  end

  @doc """
  Gets a list of tokens and parses it
  """
  def continue(tokens, env) do
    tree = Calcy.Parser.parse(tokens)
    # ir = (Calcy.IR.ir(tree))
    # IO.inspect(ir)
    eval(tree, env)
  end

  @doc """
  Runs over a list of ASTs and evaluates them
  """
  def eval(tree, env) when is_list(tree) do
    tree = List.flatten(tree)
    eval_lines(Map.merge(%{:pi => 3.1415926535897932, :e => 2.718281828459045}, env), tree, [])
  end

  @doc """
  Runs over an AST and evaluates it 
  """
  def eval(tree, env) do
    result = Calcy.Evaluator.eval(Map.merge(%{:pi => 3.1415926535897932, :e => 2.718281828459045}, env), tree)
    case result do
      :exit -> exit_program()
      _ -> IO.puts(result)
    end
    env
  end

  @doc """
  Evaluates multiple lines
  """
  def eval_lines(env, [line | lines], results) do
    result = Calcy.Evaluator.eval(env, line)
    {result, env} = check_result(result, env)
    eval_lines(env, lines, results ++ [result])
  end

  @doc """
  Prints evaulated results
  """
  def eval_lines(env, [], results) do
    Enum.map(results, fn result -> print(result) end)
    env
  end

  @doc """
  Checks the result and updates the environment if needed
  """
  def check_result(result, _env) when is_tuple(result) do
    IO.puts(result |> elem(1))
    {nil, result |> elem(0)}
  end

  @doc """
  Checks the result and updates the environment if needed
  """
  def check_result(result, env) do
    {result, env}
  end

  @doc """
  Checks if the user requested to exit
  """
  def print(val) when val == :exit do
    exit_program()
  end

  @doc """
  Prints the value if it is not nil
  """
  def print(val) do
    case val do 
      nil -> nil
      _ -> IO.puts(val)
    end
  end

  @doc """
  Greets the user with a goodbye and exits
  """
  def exit_program() do
    IO.puts("Bye bye :)")
    exit(:normal)
  end

end
