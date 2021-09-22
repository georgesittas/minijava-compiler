package symbol_table;

import java.util.*;

public class MethodInfo {
	private String id;
	private String type;

	// A list has been used for the arguments, in order to maintain their order

	private List<VarInfo> args = new ArrayList<VarInfo> ();
	private Map<String, VarInfo> vars = new HashMap<String, VarInfo> ();

	public MethodInfo(String id, String type) {
		this.id = id;
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public String getType() {
		return type;
	}

	public int getNumArgs() {
		return args.size();
	}

	public List<VarInfo> getArgs() {
		return args;
	}

	public String getArgId(int pos) throws Exception {
		return args.get(pos).getId();
	}

	public String getArgType(int pos) throws Exception {
		return args.get(pos).getType();
	}

	public VarInfo getInfo(String id) {
		if (vars.containsKey(id))
			return vars.get(id);

		int idx = args.indexOf(new VarInfo(id, null));
		return idx != -1 ? args.get(idx) : null;
	}

	public void addArg(VarInfo arg) throws Exception {
		if (args.contains(arg))
			throw new Exception("Invalid method argument (duplicate symbol)");

		args.add(arg);
	}

	public void addVar(VarInfo var) throws Exception {
		if (vars.containsKey(var.getId()) || args.contains(var))
			throw new Exception("Invalid method variable (duplicate symbol)");

		vars.put(var.getId(), var);
	}

	public void printDebugInfo() {

		System.err.println("\t\t\tArguments:");
		for (VarInfo arg : args)
			System.err.println("\t\t\t\t" + arg.getId() + ": " + arg.getType());

		System.err.println();

		System.err.println("\t\t\tLocal variables:");
		for (Map.Entry<String, VarInfo> entry : vars.entrySet()) {
			VarInfo currVar = entry.getValue();

			System.err.println("\t\t\t\t" + currVar.getId() + ": " + currVar.getType());
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;

		if (obj == null)
			return false;

		if (getClass() != obj.getClass())
			return false;

		return id.equals(((MethodInfo) obj).id);
	}

	@Override
	public int hashCode() {
		return id.hashCode();
	}
}
