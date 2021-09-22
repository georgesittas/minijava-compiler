package symbol_table;

import java.util.*;

public class ClassInfo {
	private String id;

	private Map<String, VarInfo> fields = new HashMap<String, VarInfo> ();
	private Map<String, MethodInfo> methods = new HashMap<String, MethodInfo> ();

	// Widths: 1 for booleans, 4 for ints and 8 for pointers (class types & int arrays)
	private int field_offset;
	private int method_offset;

	// Linked hash map implementation is used to maintain the order of insertion
	private Map<String, Integer> field_offsets = new LinkedHashMap<String, Integer> ();
	private Map<String, Integer> method_offsets = new LinkedHashMap<String, Integer> ();

	public ClassInfo(String id, int field_offset_begin, int method_offset_begin) {
		this.id = id;
		this.field_offset = field_offset_begin;
		this.method_offset = method_offset_begin;
	}

	public String getId() {
		return id;
	}

	public VarInfo getFieldInfo(String field_id) {
		return fields.containsKey(field_id) ? fields.get(field_id) : null;
	}

	public MethodInfo getMethodInfo(String method_id) {
		return methods.containsKey(method_id) ? methods.get(method_id) : null;
	}

	public Integer getFieldOffset() {
		return field_offset;
	}

	public Integer getFieldOffset(String field_id) {
		return field_offsets.containsKey(field_id) ? field_offsets.get(field_id) : null;
	}

	public Integer getMethodOffset() {
		return method_offset;
	}

	public Integer getMethodOffset(String method_id) {
		return method_offsets.containsKey(method_id) ? method_offsets.get(method_id) : null;
	}

	public void addField(VarInfo field) throws Exception {
		if (fields.containsKey(field.getId()))
			throw new Exception("Invalid class field (duplicate symbol)");

		fields.put(field.getId(), field);
		field_offsets.put(field.getId(), field_offset);

		if (field.getType().equals("boolean"))  field_offset += 1; // boolean
		else if (field.getType().equals("int")) field_offset += 4; // int
		else                                    field_offset += 8; // pointer
	}

	public void addMethod(MethodInfo method, boolean add_offset) throws Exception {
		if (methods.containsKey(method.getId()))
			throw new Exception("Invalid method declaration (overloaded symbol)");

		methods.put(method.getId(), method);

		// This check makes sure that we don't include offset info for overriden methods
		if (add_offset) {
			method_offsets.put(method.getId(), method_offset);
			method_offset += 8;
		}
	}

	public void printOffsets() {
		if (methods.containsKey("main"))
			return; // Skip main class

		for (Map.Entry<String, Integer> entry : field_offsets.entrySet())
			System.err.println(id + "." + entry.getKey() + " : " + entry.getValue());

		for (Map.Entry<String, Integer> entry : method_offsets.entrySet())
			System.err.println(id + "." + entry.getKey() + " : " + entry.getValue());
	}

	public void printDebugInfo() {

		System.err.println("\tFields:");
		for (Map.Entry<String, VarInfo> entry : fields.entrySet()) {
			VarInfo curr_fieldinfo = entry.getValue();

			System.err.println("\t\t" + curr_fieldinfo.getId() + ": " + curr_fieldinfo.getType());
		}

		System.err.println();

		System.err.println("\tMethods:");
		for (Map.Entry<String, MethodInfo> entry : methods.entrySet()) {
			MethodInfo curr_methodinfo = entry.getValue();

			System.err.println("\t\t" + curr_methodinfo.getId() + ": " + curr_methodinfo.getType());
			curr_methodinfo.printDebugInfo();

			System.err.println();
		}
	}
}
