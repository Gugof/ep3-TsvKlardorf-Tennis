# Patches

## Zend SplPriorityQueue PHP compatibility

File:

`src/Zend/Stdlib/src/SplPriorityQueue.php`

Changed method signature:

`public function insert($datum, $priority): true`

to:

`public function insert($datum, $priority)`

Reason: PHP fatal error with reserved/invalid return type in this vendored Zend class.
