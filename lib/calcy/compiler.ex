defmodule Calcy.Compiler do
    @moduledoc """
    The documentation for the Compiler
    """
    import IO.ANSI
    alias Calcy.{Stack, Env}

    def compile(ir, env) do
        {:ok, server} = {:ok, env}# Env.start_link([])
        {:ok, stack} = Stack.start_link([])
        compile(ir, server, stack, [])
    end

    # def compile([], _server, _stack, results) when is_list(results) do
    #     Enum.each(results, fn result -> IO.inspect(result) end)
    # end

    def print_stack(_stack, len) when len == 0 do
        
    end

    def print_stack(stack, len) do
        IO.inspect(Stack.pop(stack))
        print_stack(stack, len - 1)
    end

    def compile([], _server, stack, _results) do
        print_stack(stack, Stack.len(stack))
    end

    def compile([{:push, num} | rest], server, stack, results) do
        Stack.push(stack, num)
        compile(rest, server, stack, results)
    end

    def compile([:add | rest], server, stack, results) do
        second = Stack.pop(stack)
        first = Stack.pop(stack)
        result = first + second
        Stack.push(stack, result)
        compile(rest, server, stack, results)
    end

    def compile([:sub | rest], server, stack, results) do
        second = Stack.pop(stack)
        first = Stack.pop(stack)
        result = first - second
        Stack.push(stack, result)
        compile(rest, server, stack, results)
    end

    def compile([:mul | rest], server, stack, results) do
        second = Stack.pop(stack)
        first = Stack.pop(stack)
        result = first * second
        Stack.push(stack, result)
        compile(rest, server, stack, results)
    end

    def compile([:div | rest], server, stack, results) do
        second = Stack.pop(stack)
        first = Stack.pop(stack)
        result = first / second
        Stack.push(stack, result)
        compile(rest, server, stack, results)
    end

    def compile([:pow | rest], server, stack, results) do
        first = Stack.pop(stack)
        second = Stack.pop(stack)
        result = :math.pow(first, second)
        Stack.push(stack, result)
        compile(rest, server, stack, results)
    end

    def compile([:lookup | rest], server, stack, results) do
        symbol = Stack.pop(stack)
        {:ok, result} = Env.lookup(server, symbol)
        Stack.push(stack, result)
        compile(rest, server, stack, results)
    end

    def compile([:assign | rest], server, stack, results) do
        value = Stack.pop(stack)
        name = Stack.pop(stack)
        Env.assign(server, name, value)
        compile(rest, server, stack, results)
    end

    def compile([:nop | rest], server, stack, results) do
        compile(rest, server, stack, results)
    end

    def compile([:ret | _rest], _server, stack, _results) do
        print_stack(stack, Stack.len(stack))
        IO.puts("Bye bye :)")
        exit(:normal)
    end

    def compile([:sym | rest], server, stack, results) do
        Enum.each Env.all(server), fn {k, v} -> 
            IO.puts blue() <> "#{k}: " <> reset() <> "\t#{v}"
        end
        compile(rest, server, stack, results)
    end

    def compile(ir, _server, _stack, _results) do
        IO.inspect(ir)
    end
end