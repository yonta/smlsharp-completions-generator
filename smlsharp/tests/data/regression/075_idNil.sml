fun f (x:int list) = x
val _ = f nil

(*
2011-08-26 katsu

test3.sml:2.9-2.13 Error:
  (type inference 007) operator and operand don't agree
  operator domain: int(t0) list(t14)
  operand: ['a. 'a list(t14)]
*)

(*
2011-08-26 ohori

Fixed by adopting the following:

 >�����餯��ɬ�פʤΤϡ�unify���ʤ��ؿ�Ŭ�ѹ�ʸ�ǤϤʤ����Ȼפ��ޤ���
 >
 >�ؿ����¦�ϰ�����¿�귿��ǧ��Ƥ⡤���η���Ķ�������ƽ�����³�����
 >�褤�����ʤΤǡ��������������ʤ��Ȼפ��ޤ�����type annotation������
 >����Ф��θ�Υ���ѥ���ˤ�ƶ��ʤ��Ϥ��Ǥ���
 >
 >����ʤΤϡ��ؿ�Ŭ�Ѥ�unify����Ȥ���¿�귿�μ�갷���Ȼפ��ޤ���
 >
 >����������Ф����ñ���б��ΤҤȤĤϡ�unify�򤻤��˷���equality check
 >������Ԥ��ؿ�Ŭ�ѹ�ʸ��Ƴ�����뤳�ȤǤ���
 >
 >����ˡ����ι�ʸ��head position���ѿ��˸��ꤷ�����Ĥ����ѿ��η���ؿ���
 >�˸��ꤹ��С�rank-1 �� type instantiation �μ�갷���Ȥ���Ω���ư�����
 >�褦�ˤʤ�Ȼפ��ޤ���
 >
 >����Ū�ˤϡ�icexp �˰ʲ��Τ褦�ʹ�ʸ���ɲá�
 >
 >  ICAPPM_NOUNIFY of varInfo * icexp list * loc
 >
 >���դ���§�����̤δؿ�Ŭ�Ѥ�Ʊ�͡�
 >���������������ΤȤ���unify��Ȥ鷺�ˡ�����equality check�Τߤ�Ԥ���

*)
