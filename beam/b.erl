-module(b).

-export([call/0, recv_catch/1, old_catch/1]).

call() ->
    ok.

recv_catch(Msg) ->
    receive
        Msg ->
            Msg
    after 1000 ->
            try
                Msg * 2
            catch
                Type:E ->
                    {Type, E}
            end
    end.

old_catch(X) ->
        catch (3 - X).
