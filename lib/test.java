// import java.util.HashMap;
// import java.util.HashSet;
// public class Window{HashSet<Character>set=new HashSet<Character>();Ri tCO;String str;Integer min;Integer mS;String ch;class Ri{Character min=null;Character max=null;HashSet<Character>h=new HashSet<Character>();HashMap<Character,Integer>l=new HashMap<Character,Integer>();Ri(){for(int i=0;i<ch.length();i++)h.add(ch.charAt(i));} void insert(Character c,Integer loc){l.put(c,loc);if(min==null)min=c;if(max==null)max=c;if(l.get(min)>loc)min=c;if(l.get(max)<loc)max=c;} boolean add(Character c,Integer loc){if(h.contains(c)){insert(c,loc);h.remove(c);return co();} if(!c.equals(min))insert(c,loc);else if(gS()>(loc-l.get(max))){l.put(c,loc);min=max;max=c;} return false;} Boolean co(){return(h.isEmpty());} Boolean cGS(){return(max!=null&&min!=null);} Integer gS(){if(cGS())return l.get(max)-l.get(min);else return null;} public String toString(){return str.substring(0,l.get(min))+"|"+str.substring(l.get(min),l.get(max)+1)+"|"+str.substring(l.get(max)+1,str.length());}} void nC(Ri r){min=r.gS();mS=r.l.get(r.min);tCO=r;} Ri sM(Ri r){Ri j=new Ri();if(min==null)nC(r);else if(r.gS()<min)nC(r);for(Character c:r.l.keySet()){if(c!=r.min)j.add(c,r.l.get(c));}return j;} public Window(String s,String cA){System.out.println("S = "+s+", "+"T = "+cA);str=s;ch=cA;for(int i=0;i<cA.length();i++){set.add(cA.charAt(i));}Ri r=new Ri();for(int j=0;j<str.length();j++)if(set.contains(str.charAt(j)))if(r.add(str.charAt(j),j))r=sM(r);;System.out.println("Answer: "+tCO.toString());} public static void main(String[]args){new Window("ADO00C0BCEEACOBA","ABC");}}
