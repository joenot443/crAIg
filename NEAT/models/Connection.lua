Connection = {};

function Connection:new()
	local connection = {};
	--ID of the connection
	connection.id = 0;
	--Pointer to from Node
	connection.from = {};
	--Points to to Node
	connection.to = {};
	--Weight of the Node
	connection.weight = 0;

	connection.type = 1;
	
	return connection;
end;