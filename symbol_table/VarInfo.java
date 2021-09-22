package symbol_table;

public class VarInfo {
	private String id;
	private String type;

	public VarInfo(String id, String type) {
		this.id = id;
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public String getType() {
		return type;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;

		if (obj == null)
			return false;

		if (getClass() != obj.getClass())
			return false;

		return id.equals(((VarInfo) obj).id);
	}

	@Override
	public int hashCode() {
		return id.hashCode();
	}
}
