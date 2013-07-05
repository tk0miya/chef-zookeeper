zookeeper Cookbook
==================
Installs and configures ZooKeeper (single node)

Requirements
------------
java
CentOS 6.x

Attributes
----------
Nothing yet.

Usage
-----
Just include `zookeeper` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zookeeper]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Apache 2.0 License.

Takeshi KOMIYA <i.tkomiya@gmail.com>
