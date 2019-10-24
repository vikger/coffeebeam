-module(pizza).
-export([start/0, stop/0, order/1]).

start() ->
    register(restaurant, spawn(fun() -> restaurant() end)).

stop() ->
    restaurant ! stop,
    unregister(restaurant),
    ok.

restaurant() ->
    Preparation = spawn(fun() -> preparation() end),
    restaurant_loop(Preparation).

restaurant_loop(Preparation) ->
    receive
	{order, Customer, Type} ->
	    Preparation ! {prepare, Customer, Type},
	    restaurant_loop(Preparation);
	{ready, Customer, Pizza} ->
	    Customer ! {pizza, Pizza},
	    restaurant_loop(Preparation);
        stop ->
            Preparation ! stop;
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
	    preparation(Cook);
        stop ->
            Cook ! stop
    end.

cook() ->
    receive
	{cook, Customer, Type} ->
	    restaurant ! {ready, Customer, Type},
	    cook();
        stop ->
            ok
    end.

order(Type) ->
    try
        restaurant ! {order, self(), Type},
        receive
            {pizza, Pizza} ->
                {here_you_are, Pizza}
        end
    catch
        _:_ ->
            sorry_closed
    end.
