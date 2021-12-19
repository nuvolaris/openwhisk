package org.apache.openwhisk.standalone

package org.apache.openwhisk

import _root_.org.scalatest.Matchers
import _root_.org.scalatest.FlatSpec

class MiscTest extends FlatSpec with Matchers {
  behavior of "misc"
  println(s"Local Host Name: ${StandaloneDockerSupport.getLocalHostName()}")
  println(s"Local Internal Name: ${StandaloneDockerSupport.getLocalHostInternalName()}")
}