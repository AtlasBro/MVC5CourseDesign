using Microsoft.CSharp;
using System;
using System.CodeDom.Compiler;
using System.Text;

namespace rui
{
    /// <summary>
    /// 表达式计算
    /// </summary>
    public class expressionComputer
    {
        /// <summary>
        /// 计算1
        /// </summary>
        /// <param name="formula"></param>
        /// <param name="lz"></param>
        /// <param name="jz"></param>
        /// <param name="zsz"></param>
        /// <param name="psz"></param>
        /// <param name="xs"></param>
        /// <returns></returns>
        public static double Calculate(string formula, double lz, double jz, double zsz, double psz, double xs)
        {
            CSharpCodeProvider provider = new CSharpCodeProvider();
            CompilerParameters parameter = new CompilerParameters();
            parameter.ReferencedAssemblies.Add("System.dll");
            parameter.GenerateExecutable = false; //<--不生成exe
            parameter.GenerateInMemory = true; //<--直接在内存运行
            CompilerResults result = provider.CompileAssemblyFromSource(parameter,GenerateCodeBlocks(formula));
            //动态编译（VisualStudio F5的时候也是做这个）
            if (result.Errors.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                foreach (CompilerError error in result.Errors)
                {
                    sb.AppendLine(error.ErrorText);
                }
                return 0;
            }
            //编译成功
            double calculated = Convert.ToDouble(result.CompiledAssembly.GetType("demo.calculation").GetMethod("dowork").Invoke(null, new object[] { lz, jz, zsz, psz ,xs}));
            //这里通过反射调
            return calculated;
        }
        /// <summary>
        /// 计算2
        /// </summary>
        /// <param name="formula"></param>
        /// <param name="zl"></param>
        /// <param name="zzl"></param>
        /// <param name="hz"></param>
        /// <returns></returns>
        public static double Calculate折足率(string formula, double zl, double zzl, double hz)
        {
            CSharpCodeProvider provider = new CSharpCodeProvider();
            CompilerParameters parameter = new CompilerParameters();
            parameter.ReferencedAssemblies.Add("System.dll");
            parameter.GenerateExecutable = false; //<--不生成exe
            parameter.GenerateInMemory = true; //<--直接在内存运行
            CompilerResults result = provider.CompileAssemblyFromSource(parameter, GenerateCodeBlocks折足率(formula));
            //动态编译（VisualStudio F5的时候也是做这个）
            if (result.Errors.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                foreach (CompilerError error in result.Errors)
                {
                    sb.AppendLine(error.ErrorText);
                }
                return 0;
            }
            //编译成功
            double calculated = Convert.ToDouble(result.CompiledAssembly.GetType("demo.calculation折足率").GetMethod("dowork").Invoke(null, new object[] { zl, zzl, hz }));
            //这里通过反射调
            return calculated;
        }

        //生成表达式
        private static string GenerateCodeBlocks(string formula)
        {
            string code =
                "using System;" +
                "namespace demo" +
                "{" +
                   "public static class calculation" +
                   "{" +
                   "public static double dowork(double lz, double jz, double zsz, double psz, double xs)" +
                   "{ return " + formula +
                   ";}}}"; //这里是将你的formula和代码片段拼接成完整的程序准备编译的过程。
            return code;
        }

        private static string GenerateCodeBlocks折足率(string formula)
        {
            string code =
                "using System;" +
                "namespace demo" +
                "{" +
                   "public static class calculation折足率" +
                   "{" +
                   "public static double dowork(double zl, double zzl, double hz)" +
                   "{ return " + formula +
                   ";}}}"; //这里是将你的formula和代码片段拼接成完整的程序准备编译的过程。
            return code;
        }
    }
}
