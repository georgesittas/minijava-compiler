package symbol_table;

import java.util.*;

public class SymbolTable {

	// The linked hash map implementation has been chosen in order to maintain the order
	// of class declarations, so that the offsets can be printed in the same order.

	private Map<String, String> superclass = new HashMap<String, String> ();
	private Map<String, ClassInfo> classes = new LinkedHashMap<String, ClassInfo> ();

	public List<String> getClasses() {
		return new ArrayList<String> (classes.keySet());
	}

	public ClassInfo getClassInfo(String class_id) {
		return classes.containsKey(class_id) ? classes.get(class_id) : null;
	}

	public void addClass(String class_id, String superclass_id) throws Exception {
		int field_offset_begin = 0;
		int method_offset_begin = 0;

		if (classes.containsKey(class_id))
			throw new Exception("Invalid class declaration (duplicate symbol)");

		if (superclass_id != null) {
			if (!classes.containsKey(superclass_id))
				throw new Exception("Invalid super class (undefined symbol)");

			ClassInfo superclass_info = getClassInfo(superclass_id);

			// If class corresponding to class_id inherits from another class, make sure
			// to begin offset-counting appropriately, following the superclass' counters

			field_offset_begin = superclass_info.getFieldOffset();
			method_offset_begin = superclass_info.getMethodOffset();
		}

		classes.put(class_id, new ClassInfo(class_id, field_offset_begin, method_offset_begin));
		superclass.put(class_id, superclass_id);
	}

	public boolean isDerivedFrom(String target, String candidate_superclass) {
		String found = superclass.get(target);
		return found == null                      ? false
		     : found.equals(candidate_superclass) ? true
		     : isDerivedFrom(found, candidate_superclass);
	}

	public String getSuperClassId(String class_id) {
		return superclass.get(class_id);
	}

	public void printOffsets() {
		for (Map.Entry<String, ClassInfo> entry : classes.entrySet())
			entry.getValue().printOffsets();

		System.err.println();
	}

	public void printDebugInfo() {

		// Print inheritance info
		for (Map.Entry<String, String> entry : superclass.entrySet()) {
			if (entry.getValue() != null)
				System.err.println(entry.getKey() + " inherits from " + entry.getValue());
			else
				System.err.println(entry.getKey() + " does not inherit from any class");
		}

		System.err.println();

		// Print complete class info
		for (Map.Entry<String, ClassInfo> entry : classes.entrySet()) {
			ClassInfo curr_classinfo = entry.getValue();

			System.err.println("class " + curr_classinfo.getId());
			curr_classinfo.printDebugInfo();

			System.err.println();
		}
	}
}
