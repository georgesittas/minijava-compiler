SRC = Main.java \
      STVisitor.java \
      SCVisitor.java \
      VTVisitor.java \
      CGVisitor.java \
      vtable/VTable.java \
      vtable/VTInfo.java \
      symbol_table/VarInfo.java \
      symbol_table/MethodInfo.java \
      symbol_table/ClassInfo.java \
      symbol_table/SymbolTable.java

JARS = jars

all: compile

compile:
	@java -jar $(JARS)/jtb132di.jar -te minijava.jj
	@java -jar $(JARS)/javacc5.jar minijava-jtb.jj
	@javac $(SRC)

clean:
	@printf "Cleaning up ..."; \
	rm -f *.class symbol_table/*.class vtable/*.class; \
	rm -f JavaCharStream.java minijava-jtb.jj MiniJavaParser* ParseException.java Token*; \
	rm -rf visitor syntaxtree; \
	echo " Done!"
