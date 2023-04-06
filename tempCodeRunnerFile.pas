program PohonBiner;

type
  TreeNode = record
    data: integer;
    left, right: ^TreeNode;
  end;

  Tree = ^TreeNode;

var
  root: Tree;

procedure TambahNode(var tree: Tree; data: integer);
begin
  if tree = nil then
  begin
    new(tree);
    tree^.data := data;
    tree^.left := nil;
    tree^.right := nil;
  end
  else if data < tree^.data then
  begin
    TambahNode(tree^.left, data);
  end
  else
  begin
    TambahNode(tree^.right, data);
  end;
end;

procedure InorderTraversal(tree: Tree);
begin
  if tree <> nil then
  begin
    InorderTraversal(tree^.left);
    Write(tree^.data, ' ');
    InorderTraversal(tree^.right);
  end;
end;

procedure PreorderTraversal(tree: Tree);
begin
  if tree <> nil then
  begin
    Write(tree^.data, ' ');
    PreorderTraversal(tree^.left);
    PreorderTraversal(tree^.right);
  end;
end;

procedure PostorderTraversal(tree: Tree);
begin
  if tree <> nil then
  begin
    PostorderTraversal(tree^.left);
    PostorderTraversal(tree^.right);
    Write(tree^.data, ' ');
  end;
end;

procedure BuatPohon();
var
  n, i, data: integer;
begin
  Write('Masukkan jumlah node yang ingin ditambahkan: ');
  ReadLn(n);

  for i := 1 to n do
  begin
    Write('Masukkan data node ke-', i, ': ');
    ReadLn(data);
    TambahNode(root, data);
  end;
end;

begin
  root := nil;
  BuatPohon();

  Write('Traversal inorder: ');
  InorderTraversal(root);
  WriteLn;

  Write('Traversal preorder: ');
  PreorderTraversal(root);
  WriteLn;

  Write('Traversal postorder: ');
  PostorderTraversal(root);
  WriteLn;
end.