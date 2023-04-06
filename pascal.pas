rogram BinaryTree;

type
  TreeNode = record
    value: Char;
    left, right: ^TreeNode;
  end;

var
  root: ^TreeNode;

function NewNode(value: Char): ^TreeNode;
var
  node: ^TreeNode;
begin
  New(node);
  node^.value := value;
  node^.left := nil;
  node^.right := nil;
  NewNode := node;
end;

procedure Insert(node: ^TreeNode; value: Char);
begin
  if value < node^.value then
  begin
    if node^.left = nil then
      node^.left := NewNode(value)
    else
      Insert(node^.left, value);
  end
  else
  begin
    if node^.right = nil then
      node^.right := NewNode(value)
    else
      Insert(node^.right, value);
  end;
end;

procedure BuildTree(var root: ^TreeNode; str: string);
var
  i: Integer;
begin
  root := NewNode(str[1]);
  for i := 2 to Length(str) do
    Insert(root, str[i]);
end;

procedure InOrderTraversal(node: ^TreeNode);
begin
  if node <> nil then
  begin
    InOrderTraversal(node^.left);
    Write(node^.value);
    InOrderTraversal(node^.right);
  end;
end;

procedure PreOrderTraversal(node: ^TreeNode);
begin
  if node <> nil then
  begin
    Write(node^.value);
    PreOrderTraversal(node^.left);
    PreOrderTraversal(node^.right);
  end;
end;

procedure PostOrderTraversal(node: ^TreeNode);
begin
  if node <> nil then
  begin
    PostOrderTraversal(node^.left);
    PostOrderTraversal(node^.right);
    Write(node^.value);
  end;
end;

begin
  BuildTree(root, 'JELKYWALIYA');
  WriteLn('In-order traversal:');
  InOrderTraversal(root);
  WriteLn;
  WriteLn('Pre-order traversal:');
  PreOrderTraversal(root);
  WriteLn;
  WriteLn('Post-order traversal:');
  PostOrderTraversal(root);
end.