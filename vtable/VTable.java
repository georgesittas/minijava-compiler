package vtable;

import java.util.*;
import symbol_table.*;

public class VTable {

	// A linked hash map has been used to maintain the order of class insertion,
	// since we'd like to emit the code for each vtable in this same order.

	private Map<String, List<VTInfo>> class_to_methods =
	                                         new LinkedHashMap<String, List<VTInfo>> ();

	public List<VTInfo> getMethods(String class_id) {
		return !class_to_methods.containsKey(class_id) ? null
		                                               : class_to_methods.get(class_id);
	}

	public int getNumMethods(String class_id) throws Exception {
		return class_to_methods.get(class_id).size();
	}

	public void addClass(String class_id) throws Exception {
		if (class_to_methods.containsKey(class_id))
			throw new Exception("Duplicate class symbol in vtable");

		class_to_methods.put(class_id, new ArrayList<VTInfo> () );
	}

	public void addMethod(String class_id, String owner, MethodInfo method) throws Exception {
		if (!class_to_methods.containsKey(class_id))
			throw new Exception("Class not found in vtable");

		VTInfo new_entry = new VTInfo(owner, method);
		List<VTInfo> methods = class_to_methods.get(class_id);

		// When a subclass overrides a method, just update the corresponding entry

		if (methods.contains(new_entry))
			methods.set(methods.indexOf(new_entry), new_entry);
		else
			methods.add(new_entry);
	}

	public void printDebugInfo() {

		for (Map.Entry<String, List<VTInfo>> entry : class_to_methods.entrySet()) {
			System.err.println("Class: " + entry.getKey());

			for (VTInfo info : entry.getValue())
				System.err.println("\t\t" + info.getOwner() + ":" + info.getMethodInfo().getId());

			System.err.println();
		}
	}
}
