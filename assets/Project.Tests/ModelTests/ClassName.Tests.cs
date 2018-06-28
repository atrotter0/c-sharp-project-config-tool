using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using Project; // <---- change 'Project' to match project name

namespace Project.Tests // <---- change 'Project' to match project name
{
    [TestClass]
    public class ClassNameTest // <---- change 'ClassName' to match class name
    {
        [TestMethod]
        public void DoIPass_TestToSeeIfThisWorks_True()
        {
            ClassNameTest newObject = new ClassNameTest(); // <--- change 'ClassName' to class name
            Assert.AreEqual(true, newObject.DoIPass());
        }
    }
}