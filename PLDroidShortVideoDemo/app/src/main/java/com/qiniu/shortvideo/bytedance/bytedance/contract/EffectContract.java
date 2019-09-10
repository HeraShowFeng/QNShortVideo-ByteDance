package com.qiniu.shortvideo.bytedance.bytedance.contract;

import android.util.SparseArray;

import com.qiniu.shortvideo.bytedance.bytedance.base.BasePresenter;
import com.qiniu.shortvideo.bytedance.bytedance.base.IView;
import com.qiniu.shortvideo.bytedance.bytedance.model.ComposerNode;


/**
 * Created by QunZhang on 2019-07-22 13:45
 */
public interface EffectContract {

    interface View extends IView {

    }

    abstract class Presenter extends BasePresenter<View> {

        /**
         * 移除某一种类型的 composer node
         * Remove a certain type of composer node
         * @param composerNodeMap composer node map
         * @param type 某一种类型，如{@link ItemGetContract#TYPE_BEAUTY_FACE}，当
         *             type 为这个值时，会移除 composerNodeMap 中所有在此类目下的特效，
         *             如{@link ItemGetContract#TYPE_BEAUTY_FACE_SMOOTH}
         *             a certain type，such as {@link ItemGetContract#TYPE_BEAUTY_FACE} and
         *             {@link ItemGetContract#TYPE_BEAUTY_FACE_SMOOTH}
         *
         */
        abstract public void removeNodesOfType(SparseArray<ComposerNode> composerNodeMap, int type);

        /**
         * 根据 composer node map 生成 composer nodes
         * Generate composer nodes based on the composer node map
         * @param composerNodeMap composer node map
         * @return 返回一个 String 数组，存储所有 composer node 的路径，即{@link ComposerNode#getNode()}
         *          Returns a String array that stores all the composer node's paths, namely {@link ComposerNode#getNode()}
         */
        abstract public String[] generateComposerNodes(SparseArray<ComposerNode> composerNodeMap);
    }
}
