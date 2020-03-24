package coffeebeam.erts;

import coffeebeam.types.*;
import coffeebeam.beam.BeamDebug;

public class Lists {
    public static ErlTerm nth(ErlTerm arg1, ErlTerm arg2) {
        if (arg1 instanceof ErlInt) {
            if (arg2 instanceof ErlList) {
                int n = ((ErlInt) arg1).getValue();
                ErlList list = (ErlList) arg2;
                int i = 1;
                while (!list.isNil()) {
                    ErlTerm head = list.head;
                    if (i == n) {
                        return head;
                    }
                    if (list.tail instanceof ErlList) {
                        i++;
                        list = (ErlList) list.tail;
                    } else
                        return new ErlException(new ErlAtom("badarg"));
                }
            }
        }
        return new ErlException(new ErlAtom("badarg"));
    }

    public static ErlTerm append(ErlTerm arg1, ErlTerm arg2) {
        if (arg1 instanceof ErlList) {
            ErlList list1 = (ErlList) arg1;
            ErlList result = new ErlList();

            while (!list1.isNil()) {
                result.add(list1.head);
                if (list1.tail instanceof ErlList) {
                    list1 = (ErlList) list1.tail;
                } else
                    return new ErlException(new ErlAtom("badarg"));
            }
            result.setTail(arg2);
            return result;
        }
        return new ErlException(new ErlAtom("badarg"));
    }
}
