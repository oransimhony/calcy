# Calcy

A CLI application I built using [leex](http://erlang.org/doc/man/leex.html) and [yecc](http://erlang.org/doc/man/yecc.html).

This calcy can solve expressions with + - * / ^ and also use variables.

## Installation
For this program to work you need to have [Elixir](https://elixir-lang.org/install.html) installed on your computer.

Clone to your computer using
```
https://github.com/ohmn123/calcy.git
```

## Running
Enter the directory where you installed it
```
cd calcy
```
Build the application using
```
mix compile
mix escript.build
```
Run using
```
./calcy
```
> You may need to change the permissions:
> ```
> chmod +x ./calcy
> ```

## Usage
Write any expression normally
```elixir
calcy> 1 + 2 * (4 / 2) ^ 12
8193.0
```
You can use the predefined constants $\pi$ and $e$
```elixir
calcy> e / pi
0.8652559794322651
```
You can use both integers and floats
```elixir
calcy> 15.3 ^ 0.5 - 123
-119.08847855687841
```
You can define variables
```elixir
calcy> r = 5
5
calcy> area = pi * r ^ 2
78.53981633974483
calcy> diameter = r * 2
10
calcy> perimeter = pi * diameter
31.41592653589793
```
To see list of variables use
```elixir
calcy> stack
e:      2.718281828459045
pi:     3.141592653589793
```
To exit the program use
```
calcy> exit
Bye bye :)
```
(Or use CTRL+C)

Thank you for reading! Have fun using it ✨

## Authors
*  **Oran Simhony** - [ohmn123](https://github.com/ohmn123)