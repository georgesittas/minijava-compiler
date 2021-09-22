package vtable;

import symbol_table.*;

public class VTInfo {
	private String owner;
	private MethodInfo method_info;

	public VTInfo(String owner, MethodInfo method_info) {
		this.owner = owner;
		this.method_info = method_info;
	}

	public String getOwner() {
		return owner;
	}

	public MethodInfo getMethodInfo() {
		return method_info;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;

		if (obj == null)
			return false;

		if (getClass() != obj.getClass())
			return false;

		return method_info.equals(((VTInfo) obj).method_info);
	}

	@Override
	public int hashCode() {
		return method_info.hashCode();
	}
}
