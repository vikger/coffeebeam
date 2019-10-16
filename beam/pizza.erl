-module(pizza).
-export([start/0, order/1]).

start() ->
    register(restaurant, spawn(fun() -> restaurant() end)).

restaurant() ->
    Preparation = spawn(fun() -> preparation() end),
    restaurant_loop(Preparation).

restaurant_loop(Preparation) ->
    receive
	{order, Customer, Type} ->
	    Preparation ! {prepare, Customer, Type},
	    restaurant_loop(Preparation);
	{ready, Customer, Pizza} ->
	    Customer ! Pizza,
	    restaurant_loop(Preparation);
	X ->
	    io:format("receive ~p", [X]),
	    restaurant_loop(Preparation)
    end.

preparation() ->
    Cook = spawn(fun() -> cook() end),
    preparation(Cook).

preparation(Cook) ->
    receive
	{prepare, Customer, Type} ->
	    Cook ! {cook, Customer, Type},
	    preparation(Cook)
    end.

cook() ->
    receive
	{cook, Customer, Type} ->
	    restaurant ! {ready, Customer, Type},
	    cook()
    end.

order(Type) ->
    restaurant ! {order, self(), Type},
    receive
	Pizza ->
	    Pizza
    end.
