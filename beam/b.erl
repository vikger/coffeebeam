-module(b).

-export([call/0, recv_catch/1, old_catch/1, try_catch/0, throw/0, bin/1, bin1/1]).

call() ->
    ok.

recv_catch(Msg) ->
    receive
        Msg ->
            Msg
    after 1000 ->
            try
                erlang:unknown_function(Msg)
            catch
                Type:E ->
                    {Type, E}
            end
    end.

old_catch(X) ->
        catch (3 - X).

try_catch() ->
    try
        erlang:unknown_function()
    catch
        Type:E ->
            {Type, E}
    end.

throw() ->
    throw(strange).

bin(X) ->
    <<X,100,101,102>>.

bin1(X) ->
    <<48,49,50,51,X>>.
