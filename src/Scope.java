import java.util.*;

/**
 * Created by Noble Notebook Louis on 15-May-17.
 */
public class Scope {

    private Deque stack = new ArrayDeque<Set<String>>();

    public Scope() {
        this.stack = new ArrayDeque<>();
        openScope();
    }

    public void openScope() {
        this.stack.addLast(new HashSet<>());
    }

    public void closeScope() throws RuntimeException {
        if (stack.size() == 1) {
            throw new RuntimeException();
        }
        this.stack.removeLast();
    }

    public boolean add(String id)  {
        Set<String> last = (Set) this.stack.getLast();
        if (last.contains(id)) {
            return false;
        }
        Set<String> temp = (Set) this.stack.removeLast();
        temp.add(id);
        this.stack.addLast(temp);
        return true;
    }

    public boolean contains(String id) {
        for (Iterator itr = stack.iterator(); itr.hasNext();) {
            for (Object s : (Set) itr.next()) {
                if (s.equals(id)) {
                    return true;
                }
            }
        }
        return false;
    }
}
